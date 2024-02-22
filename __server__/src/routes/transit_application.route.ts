import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { isPetOwner } from '../_core/middlewares/is_pet_owner.middleware';
import { createTransitApplication } from '../controllers/transit_application.controller';

const router = Router();

const commonMiddlewares = [
    isAuthenticated,
    isPetOwner
];

router.post('/application/v1/transit', commonMiddlewares, createTransitApplication as any);

export default router;