import Joi from 'joi';

export const validatoCreatePet = (body: any) => {
    const { error } = Joi.object({
        name: Joi.string().min(2).max(75).required(),
        specie: Joi.string().min(2).max(75).required(),
        age: Joi.number().required(),
        gender: Joi.string().valid('male', 'female', 'other').required(),
        identification: Joi.string().min(2).max(75).required(),
        additionalInfo: Joi.object({
            historyOfBitting: Joi.boolean().required(),
            feedingInstructions: Joi.string().min(6).max(255).required(),
            medicationInstructions: Joi.string().min(6).max(255).required(),
        }).required(),
    }).validate(body);

    return error;
};
