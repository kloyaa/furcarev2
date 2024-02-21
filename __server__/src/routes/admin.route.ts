import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { getCustomers, getStaffs } from '../controllers/admin.controller';
const router = Router();

const commonMiddlewares = [
    isAuthenticated
];

router.get('/admin/v1/customers', getCustomers as any);
router.get('/admin/v1/staffs', getStaffs as any);

export default router;
