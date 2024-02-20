import { Schema, model } from 'mongoose';
import { IBooking } from '../_core/interfaces/schema/schema.interface';
import { BookingStatus } from '../_core/enum/booking.enum';

const bookingSchema = new Schema<IBooking>(
    {
        user: {
            type: Schema.Types.ObjectId,
            ref: 'User',
            required: true,
        },
        pet: {
            type: Schema.Types.ObjectId,
            ref: 'Pet',
            required: true,
        },
        service: {
            type: Schema.Types.ObjectId,
            ref: 'Service',
            required: true,
        },
        status: {
            type: String,
            enum: Object.values(BookingStatus),
            required: true,
        },
    },
    { timestamps: true },
);

const Booking = model<IBooking>('Booking', bookingSchema);

export default Booking;
