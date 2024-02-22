import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { getBoardingApplicationsByAppId, getBookings, getGroomingApplicationsByAppId, getTransactions, updateBookingStatusById } from '../controllers/booking.controller';
import { isStaff } from '../_core/middlewares/is_staff.middleware';
import { isProfileCreated } from '../_core/middlewares/is_profile_created.middleware';
const router = Router();

const commonMiddlewares = [
    isAuthenticated,
    isStaff,
    isProfileCreated
];

router.get('/staff/v1/booking', commonMiddlewares, getBookings as any);
router.get('/staff/v1/booking/grooming/:_id', commonMiddlewares, getGroomingApplicationsByAppId as any);
router.get('/staff/v1/booking/boarding/:_id', commonMiddlewares, getBoardingApplicationsByAppId as any);
router.put('/staff/v1/booking/status', commonMiddlewares, updateBookingStatusById as any);
router.get('/staff/v1/transactions', commonMiddlewares, getTransactions as any);

export default router;