import { isObjectIdOrHexString } from "mongoose";
import { statuses } from "../_core/const/api.statuses";
import { TRequest, TResponse } from "../_core/interfaces/overrides.interface";
import GroomingApplication from "../models/grooming_application.schema";
import BookingSchedule from "../models/schedule.model";
import Booking from "../models/booking.model";
import Pet from "../models/pet.schema";
import { BookingStatus } from "../_core/enum/booking.enum";
import { findServiceFeeByTitle } from "../services/service_fee.service";

export const createGroomingApplication = async (req: TRequest, res: TResponse) => {
    try {
        const { schedule: scheduleId, pet: petId } = req.body;
        if (!isObjectIdOrHexString(scheduleId) || !isObjectIdOrHexString(petId)) {
            return res.status(400).json(statuses["0901"]);
        }

        const schedule = await BookingSchedule.findById(scheduleId);
        if (!schedule) {
            return res.status(404).json(statuses["02"]);
        }

        const pet = await Pet.findOne({ user: req.user.id });
        if (!pet) {
            return res.status(404).json(statuses['99001']);
        }

        const newGroomingApplication = new GroomingApplication({ schedule });

        await newGroomingApplication.save();

        const serviceFee = await findServiceFeeByTitle("grooming");

        const newBooking = new Booking({
            application: newGroomingApplication._id,
            user: req.user.id,
            pet: petId,
            status: BookingStatus.Pending,
            payable: serviceFee?.fee ?? 0
        })

        await newBooking.save();

        return res.status(201).json(statuses["00"]);
    } catch (error) {
        console.error('Error creating grooming application:', error);
        return res.status(500).json({ message: 'Internal server error' });
    }
};