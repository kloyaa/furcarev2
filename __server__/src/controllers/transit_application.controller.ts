import { isObjectIdOrHexString } from "mongoose";
import { statuses } from "../_core/const/api.statuses";
import { TRequest, TResponse } from "../_core/interfaces/overrides.interface";
import { validateCreateTransitApplication } from "../_core/validators/application.validator";
import Pet from "../models/pet.schema";
import TransitApplication from "../models/transit_application.schema";
import { findServiceFeeByTitle } from "../services/service_fee.service";
import { BookingServiceType, BookingStatus } from "../_core/enum/booking.enum";
import Booking from "../models/booking.model";

export const createTransitApplication = async (req: TRequest, res: TResponse) => {
    try {
        const error = validateCreateTransitApplication(req.body);
        if (error) {
            return res.status(403).json({
                ...statuses['501'],
                message: error.details[0].message.replace(/['"]/g, ''),
            });
        }

        const { schedule, pet: petId } = req.body;

        const pet = await Pet.findOne({ user: req.user.id, _id: petId });
        if (!pet) {
            return res.status(404).json(statuses['99001']);
        }

        const newTransitApplication = new TransitApplication({ schedule });

        await newTransitApplication.save();

        const serviceFee = await findServiceFeeByTitle(BookingServiceType.Transit);

        const newBooking = new Booking({
            application: newTransitApplication._id,
            applicationType: BookingServiceType.Boarding,
            user: req.user.id,
            pet: petId,
            status: BookingStatus.Pending,
            payable: serviceFee?.fee ?? 0
        })

        await newBooking.save();

        return res.status(200).json(statuses["00"])
    } catch (error) {
        console.log('@createTransitApplication error', error);
        return res.status(401).json(statuses['0900']);
    }
}