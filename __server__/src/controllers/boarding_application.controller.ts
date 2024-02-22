import { statuses } from "../_core/const/api.statuses";
import { TRequest, TResponse } from "../_core/interfaces/overrides.interface";
import Cage from "../models/cage.schema";
import Pet from "../models/pet.schema";
import BoardingApplication from "../models/boarding_application.schema";
import { validateCreateBoardingApplication } from "../_core/validators/application.validator";
import { BookingServiceType, BookingStatus } from "../_core/enum/booking.enum";
import Booking from "../models/booking.model";
import { findServiceFeeByTitle } from "../services/service_fee.service";

export const createBoardingApplication = async (req: TRequest, res: TResponse) => {
    try {
        const error = validateCreateBoardingApplication(req.body);
        if (error) {
            return res.status(403).json({
                ...statuses['501'],
                message: error.details[0].message.replace(/['"]/g, ''),
            });
        }

        const { cage: cageId, pet: petId, schedule, daysOfStay } = req.body;

        const cage = await Cage.findById(cageId);
        if (!cage) {
            return res.status(404).json(statuses["02"]);
        }

        const pet = await Pet.findOne({ user: req.user.id, _id: petId });
        if (!pet) {
            return res.status(404).json(statuses['99001']);
        }

        const newBoardingApplication = new BoardingApplication({
            schedule,
            daysOfStay,
            cage: cageId
        });

        await newBoardingApplication.save();

        const serviceFee = await findServiceFeeByTitle(BookingServiceType.Boarding);

        const newBooking = new Booking({
            application: newBoardingApplication._id,
            applicationType: BookingServiceType.Boarding,
            user: req.user.id,
            pet: petId,
            status: BookingStatus.Pending,
            payable: serviceFee?.fee ?? 0
        })

        await newBooking.save();

        return res.status(200).json(statuses["00"])
    } catch (error) {
        console.error('@createBoardingApplication', error);
        return res.status(500).json(statuses["0900"]);
    }

}