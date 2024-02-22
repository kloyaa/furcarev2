import { isObjectIdOrHexString } from "mongoose";
import { statuses } from "../_core/const/api.statuses";
import { TRequest, TResponse } from "../_core/interfaces/overrides.interface";
import BoardingApplication from "../models/boarding_application.schema";
import Booking from "../models/booking.model";
import GroomingApplication from "../models/grooming_application.schema";

export const getBookings = async (req: TRequest, res: TResponse) => {
    try {
        const bookings = await Booking.find();
        return res.status(200).json(bookings);
    } catch (error) {
        return res.status(500).json(statuses["0900"])
    }
}

export const getGroomingApplicationsByAppId = async (req: TRequest, res: TResponse) => {
    try {
        if(!isObjectIdOrHexString(req.params._id)) {
            return res.status(400).json(statuses["0901"]);
        }
        const application = await GroomingApplication
            .findById(req.params._id)
            .populate('schedule');
        if(!application) {
            return res.status(400).json(statuses["02"]);
        }
        return res.status(200).json(application);
    } catch (error) {
        return res.status(500).json(statuses["0900"])
    }
}

export const getBoardingApplicationsByAppId = async (req: TRequest, res: TResponse) => {
    try {
        if(!isObjectIdOrHexString(req.params._id)) {
            return res.status(400).json(statuses["0901"]);
        }
        const application = await BoardingApplication
            .findById(req.params._id)
            .populate('cage');
        if(!application) {
            return res.status(400).json(statuses["02"]);
        }
        return res.status(200).json(application);
    } catch (error) {
        return res.status(500).json(statuses["0900"])
    }
}