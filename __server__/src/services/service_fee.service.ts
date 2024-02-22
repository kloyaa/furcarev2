import { BookingServiceType } from "../_core/enum/booking.enum";
import ServiceFee from "../models/service_fee.schema";

export const findServiceFeeByTitle = async (title: BookingServiceType) => {
    try {
        const service = await ServiceFee.findOne({ title });
        if (!service) {
            return null;
        }
        return service;
    } catch (error) {
        return null;
    }
}