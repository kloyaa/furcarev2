import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { getBoardingApplicationsByAppId, getBookings, getGroomingApplicationsByAppId } from '../controllers/booking.controller';
import { isStaff } from '../_core/middlewares/is_staff.middleware';
const router = Router();

const commonMiddlewares = [
    isAuthenticated,
    isStaff
];

router.get('/staff/v1/booking', commonMiddlewares, getBookings as any);
router.get('/staff/v1/booking/grooming/:_id', commonMiddlewares, getGroomingApplicationsByAppId as any);
router.get('/staff/v1/booking/boarding/:_id', commonMiddlewares, getBoardingApplicationsByAppId as any);

export default router;