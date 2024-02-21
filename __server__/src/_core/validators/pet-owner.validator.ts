import Joi from 'joi';
import { IPetOwner } from '../interfaces/schema/schema.interface';

export const validatorSavePetOwner = (body: any) => {
    const { error } = Joi.object({
        emergencyContactNo: Joi.string()
            .trim()
            .pattern(/^09\d{9}$/) // Pattern for a valid Philippine mobile number starting with '09'
            .messages({ 'string.pattern.base': 'Invalid Mobile No. format' })
            .required(),
        work: Joi.string().min(6).max(255).required(),
    } as { [key in keyof IPetOwner]: Joi.Schema }).validate(body);

    return error;
};


export const validatorUpdatePetOwner = (body: any) => {
    const { error } = Joi.object({
        name: Joi.string().min(2).max(255).required(),
        address: Joi.string().min(5).max(255).required(),
        mobileNo: Joi.string()
            .trim()
            .pattern(/^09\d{9}$/) // Pattern for a valid Philippine mobile number starting with '09'
            .messages({ 'string.pattern.base': 'Invalid Mobile No. format' })
            .required(),
        email: Joi.string().email().required(),
        emergencyContactNo: Joi.string().min(11).max(11).required(),
        work: Joi.string().min(6).max(255).required(),
    } as { [key in keyof IPetOwner]: Joi.Schema }).validate(body);
    return error;
};
