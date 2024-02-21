import ServiceFee from "../models/service_fee.schema";

export const findServiceFeeByTitle = async (title: string) => {
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