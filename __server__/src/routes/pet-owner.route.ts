import { Router } from 'express';
import { isAuthenticated } from '../_core/middlewares/jwt.middleware';
import { savePetOwner } from '../controllers/pet_owner.controller';
import { isValidUser } from '../_core/middlewares/is_valid_user.middleware';
import { isProfileCreated } from '../_core/middlewares/is_profile_created.middleware';

const router = Router();

const commonMiddlewares = [
    isAuthenticated,
    isValidUser,
    // isProfileCreated
];

router.post('/owner/v1', commonMiddlewares, savePetOwner as any);
// router.get('/pet-owner/v1', commonMiddlewares, getPetOwners as any);
// router.get('/pet-owner/v1/data', commonMiddlewares, getPetOwnersData as any);
// router.get('/pet-owner/v1/me', commonMiddlewares, getPetOwnersByUserId as any);
// router.get('/pet-owner/v1/s/:_id', commonMiddlewares, getPetOwnerDetailsByUserId as any);
// router.put('/pet-owner/v1', commonMiddlewares, updatePetOwner as any);
// router.put('/pet-owner/v1/:_id', commonMiddlewares, updatePetOwnerDetailsById as any);

export default router;
