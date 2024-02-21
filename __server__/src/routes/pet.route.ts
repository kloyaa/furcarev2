import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { isValidUser } from '../_core/middlewares/is_valid_user.middleware';
import { isPetOwner } from '../_core/middlewares/is_pet_owner.middleware';
import { createPet, getPetByAccessToken, updatePetByAccessToken } from '../controllers/pet.controller';

const router = Router();

const commonMiddlewares = [
    isAuthenticated,
    isValidUser,
    isPetOwner
];

router.post('/pet/v1/me', commonMiddlewares, createPet as any);
router.get('/pet/v1/me', commonMiddlewares, getPetByAccessToken as any);
router.put('/pet/v1/me', commonMiddlewares, updatePetByAccessToken as any);

export default router;
