import { Schema, model } from 'mongoose';
import { IPet } from '../_core/interfaces/schema/schema.interface';

const petSchema = new Schema<IPet>(
    {
        user: {
            type: Schema.Types.ObjectId,
            ref: 'User',
            required: true,
        }, // Reference to the User model
        name: {
            type: String,
            required: true,
        },
        specie: {
            type: String,
            required: true,
        },
        age: {
            type: Number,
            required: true,
        },
        gender: {
            type: String,
            required: true,
        },
        identification: {
            type: String,
            required: true,
        },
        additionalInfo: {
            historyOfBitting: {
                type: Boolean,
                required: true,
            },
            feedingInstructions: {
                type: String,
                required: true,
            },
            medicationInstructions: {
                type: String,
                required: true,
            }
        }
    },
    { timestamps: true },
);

const Pet = model<IPet>('Pet', petSchema);

export default Pet;
