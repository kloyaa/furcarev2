import Joi from "joi";
import { isObjectIdOrHexString } from "mongoose";

export const validateCreateBoardingApplication = (body: any) => {
    const { error } = Joi.object({
        schedule: Joi.date().iso().required(),
        daysOfStay: Joi.number().required(),
        cage: Joi
            .string()
            .custom((value, helpers) => {
                if (!isObjectIdOrHexString(value)) {
                    return helpers.error('any.invalid');
                }
                return value;
            })
            .required(),
        pet: Joi
            .string()
            .custom((value, helpers) => {
                if (!isObjectIdOrHexString(value)) {
                    return helpers.error('any.invalid');
                }
                return value;
            })
            .required(),
    }).validate(body);

    return error;
};

export const validateCreateTransitApplication = (body: any) => {
    const { error } = Joi.object({
        schedule: Joi.date().iso().required(),
        pet: Joi
            .string()
            .custom((value, helpers) => {
                if (!isObjectIdOrHexString(value)) {
                    return helpers.error('any.invalid');
                }
                return value;
            })
            .required(),
    }).validate(body);

    return error;
};