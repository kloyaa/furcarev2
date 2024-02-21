import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { createGroomingApplication } from '../controllers/grooming_application.controller';
import { isPetOwner } from '../_core/middlewares/is_pet_owner.middleware';

const router = Router();

const commonMiddlewares = [
    isAuthenticated,
    isPetOwner
];

router.post('/application/v1/grooming', commonMiddlewares, createGroomingApplication as any);

export default router;