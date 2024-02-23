import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { getCheckInStats, getCustomers, getStaffs, updateUserActiveStatus } from '../controllers/admin.controller';
const router = Router();

const commonMiddlewares = [
    isAuthenticated
];

router.get('/admin/v1/customers', getCustomers as any);
router.get('/admin/v1/staffs', getStaffs as any);
router.get('/admin/v1/activity/checkins', getCheckInStats as any);
router.put('/admin/v1/management/user-status', updateUserActiveStatus as any);

export default router;
