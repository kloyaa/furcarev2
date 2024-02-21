import Joi from 'joi';
import { IPetOwner } from '../interfaces/schema/schema.interface';

export const validatorSavePetOwner = (body: any) => {
    const { error } = Joi.object({
        emergencyContactNo: Joi.string().min(11).max(11).required(),
        work: Joi.string().min(6).max(255).required(),
    } as { [key in keyof IPetOwner]: Joi.Schema }).validate(body);

    return error;
};
