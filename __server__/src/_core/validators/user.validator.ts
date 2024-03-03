import Joi from 'joi';
import { passwordRegexp } from '../const/patterns.const';
import { isObjectIdOrHexString } from 'mongoose';

export const validateCreateProfile = (body: any) => {
  const schema = Joi.object({
    firstName: Joi.string().trim().min(2).max(50).required(),
    lastName: Joi.string().trim().min(2).max(50).required(),
    birthdate: Joi.date().iso().required(),
    address: Joi.object({
      present: Joi.string().trim().min(5).max(255).messages({
        'string.min': 'Present address should be at least {#limit} characters long',
        'string.max': 'Present address cannot exceed {#limit} characters',
      }).required().messages({
        'any.required': 'Present address is required'
      }),
      permanent: Joi.string().trim().min(5).max(255).messages({
        'string.min': 'Permanent address should be at least {#limit} characters long',
        'string.max': 'Permanent address cannot exceed {#limit} characters',
      }).required().messages({
        'any.required': 'Permanent address is required'
      }),
    }).required(),
    contact: Joi.object({
      email: Joi.string().trim().email().required().messages({ 'string.email': 'Invalid email format' }),
      number: Joi.string()
        .trim()
        .pattern(/^09\d{9}$/) // Pattern for a valid Philippine mobile number starting with '09'
        .messages({ 'string.pattern.base': 'Invalid Mobile No. format' })
        .required(),
    }).required(),
    isActive: Joi.boolean().required(),
    gender: Joi.string().valid('male', 'female', 'other').required(),
  });

  const { error } = schema.validate(body);
  return error;
};

export const validateUpdateProfile = (body: any) => {
  const schema = Joi.object({
    firstName: Joi.string().trim().min(2).max(50).required(),
    lastName: Joi.string().trim().min(2).max(50).required(),
    birthdate: Joi.date().iso().required(),
    address: Joi.object({
      present: Joi.string().trim().min(5).max(255).required(),
      permanent: Joi.string().trim().min(5).max(255).required(),
    }).required(),
    contact: Joi.object({
      email: Joi.string().trim().email().required(),
      number: Joi.string()
        .trim()
        .pattern(/^09\d{9}$/) // Pattern for a valid Philippine mobile number starting with '09'
        .messages({ 'string.pattern.base': 'Invalid Mobile No. format' })
        .required(),
    }).required(),
    gender: Joi.string().valid('male', 'female', 'other').required(),
  });

  const { error } = schema.validate(body);
  return error;
};

export const validatorChangePassword = (body: any) => {
  const { error } = Joi.object({
    newPassword: Joi.string()
      .required()
      .min(6)
      .max(255)
      .pattern(passwordRegexp)
      .messages({ 'string.pattern.base': 'Password must contain at least 1 uppercase letter, 1 number, and 1 special character.' }),
    currentPassword: Joi
      .string()
      .required(),
  }).validate(body);

  return error;
};

export const validateUpdateUserActiveStatus = (body: any) => {
  const { error } = Joi.object({
    isActive: Joi.boolean().required(),
    user: Joi
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
}