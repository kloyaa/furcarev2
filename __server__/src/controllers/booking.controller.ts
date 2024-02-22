import { isObjectIdOrHexString } from "mongoose";
import { statuses } from "../_core/const/api.statuses";
import { TRequest, TResponse } from "../_core/interfaces/overrides.interface";
import BoardingApplication from "../models/boarding_application.schema";
import Booking from "../models/booking.model";
import GroomingApplication from "../models/grooming_application.schema";
import { validateUpdateBookingStatusById } from "../_core/validators/application.validator";
import { BookingStatus } from "../_core/enum/booking.enum";
import { EventName } from "../_core/enum/activity.enum";
import { emitter } from "../_core/events/activity.event";
import { IActivity } from "../_core/interfaces/activity.interface";

export const getBookings = async (req: TRequest, res: TResponse) => {
    try {
        const bookings = await Booking.find();
        return res.status(200).json(bookings);
    } catch (error) {
        console.log("@getBookings error", error)
        return res.status(500).json(statuses["0900"])
    }
}

export const getGroomingApplicationsByAppId = async (req: TRequest, res: TResponse) => {
    try {
        if (!isObjectIdOrHexString(req.params._id)) {
            return res.status(400).json(statuses["0901"]);
        }
        const application = await GroomingApplication
            .findById(req.params._id)
            .populate('schedule');
        if (!application) {
            return res.status(400).json(statuses["02"]);
        }
        return res.status(200).json(application);
    } catch (error) {
        console.log("@getBookings error", error)
        return res.status(500).json(statuses["0900"])
    }
}

export const getBoardingApplicationsByAppId = async (req: TRequest, res: TResponse) => {
    try {
        if (!isObjectIdOrHexString(req.params._id)) {
            return res.status(400).json(statuses["0901"]);
        }
        const application = await BoardingApplication
            .findById(req.params._id)
            .populate('cage');
        if (!application) {
            return res.status(400).json(statuses["02"]);
        }
        return res.status(200).json(application);
    } catch (error) {
        console.log("@getBookings error", error)
        return res.status(500).json(statuses["0900"])
    }
}

export const updateBookingStatusById = async (req: TRequest, res: TResponse) => {
    const error = validateUpdateBookingStatusById(req.body);
    if (error) {
        return res.status(403).json({
            ...statuses['501'],
            message: error.details[0].message.replace(/['"]/g, ''),
        });
    }
    try {
        const { booking: bookingId, status } = req.body;
        const update = { status, staff: req.user.id };
        const updatedBooking = await Booking.findByIdAndUpdate(bookingId, update, { new: true });

        if (!updatedBooking) {
            return res.status(404).json(statuses["02"]);
        }

        if (status == BookingStatus.Done) {
            emitter.emit(EventName.ACTIVITY, {
                user: req.user.id as any,
                description: `${updatedBooking.applicationType} completed`,
            } as IActivity);
        }

        return res.status(200).json(statuses["00"]);
    } catch (error) {
        console.log("@getBookings error", error)
        return res.status(500).json(statuses["0900"])
    }
};