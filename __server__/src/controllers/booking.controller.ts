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
import serviceTransaction from "../models/service_transactions.schema";
import ServiceTransaction from "../models/service_transactions.schema";
import { findServiceFeeByTitle } from "../services/service_fee.service";
import ServiceFee from "../models/service_fee.schema";

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
            const service = await findServiceFeeByTitle(updatedBooking.applicationType);
            const newServiceTransaction = new ServiceTransaction({
                staff: req.user.id,
                customer: updatedBooking.user,
                pet: updatedBooking.pet,
                payment: 0,
                service: service?._id,
                feedback: ""
            });

            await newServiceTransaction.save();
            emitter.emit(EventName.ACTIVITY, {
                user: req.user.id as any,
                description: `${updatedBooking.applicationType} completed`,
            } as IActivity);
        }

        if (status == BookingStatus.Declined) {
            emitter.emit(EventName.ACTIVITY, {
                user: req.user.id as any,
                description: `${updatedBooking.applicationType} declined`,
            } as IActivity);
        }

        if (status == BookingStatus.Confirmed) {
            emitter.emit(EventName.ACTIVITY, {
                user: req.user.id as any,
                description: `${updatedBooking.applicationType} confirmed`,
            } as IActivity);
        }
        return res.status(200).json(statuses["00"]);
    } catch (error) {
        console.log("@getBookings error", error)
        return res.status(500).json(statuses["0900"])
    }
};


export const getTransactions = async (req: TRequest, res: TResponse) => {
    try {
        const result = await ServiceTransaction.aggregate([
            {
                $lookup: {
                    from: 'profiles', // Collection name for staff
                    localField: 'staff',
                    foreignField: 'user',
                    as: 'staff'
                }
            },
            {
                $unwind: {
                    path: '$staff',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $lookup: {
                    from: 'profiles', // Collection name for customers
                    localField: 'customer',
                    foreignField: 'user',
                    as: 'customer'
                }
            },
            {
                $unwind: {
                    path: '$customer',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $lookup: {
                    from: 'pets', // Collection name for pets
                    localField: 'pet',
                    foreignField: '_id',
                    as: 'pet'
                }
            },
            {
                $unwind: {
                    path: '$pet',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $project: {
                    'staff.createdAt': 0,
                    'staff.updatedAt': 0,
                    'staff.__v': 0,
                    'customer.createdAt': 0,
                    'customer.updatedAt': 0,
                    'customer.__v': 0,
                    'pet.createdAt': 0,
                    'pet.updatedAt': 0,
                    'pet.__v': 0,
                    '__v': 0,
                }
            }
        ]);

        return res.status(200).json(result);
    } catch (error) {
        console.log("@getTransactions error", error)
        return res.status(500).json(statuses["0900"])
    }
}