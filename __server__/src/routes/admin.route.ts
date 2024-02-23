import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { getCheckInStats, getCustomers, getSeriveUsageStats, getStaffs, updateUserActiveStatus } from '../controllers/admin.controller';
import { getTransactions } from '../controllers/booking.controller';
const router = Router();

const commonMiddlewares = [
    isAuthenticated
];

router.get('/admin/v1/customers', getCustomers as any);
router.get('/admin/v1/staffs', getStaffs as any);
router.get('/admin/v1/stats/checkins', getCheckInStats as any);
router.get('/admin/v1/stats/service-usage', getSeriveUsageStats as any);
router.put('/admin/v1/management/user-status', updateUserActiveStatus as any);
router.get('/admin/v1/transactions', commonMiddlewares, getTransactions as any);

export default router;
