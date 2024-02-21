import { Aggregate } from "mongoose";
import { TRequest } from "../_core/interfaces/overrides.interface";
import { type Response } from 'express';
import User from "../models/user.model";

export const getCustomers = async (req: TRequest, res: Response) => {
    try {
        const getCustomerDataAggregate: Aggregate<any[]> = User.aggregate([
            {
                $lookup: {
                    from: 'profiles',
                    localField: '_id',
                    foreignField: 'user',
                    as: 'profile'
                }
            },
            {
                $unwind: {
                    path: '$profile',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $lookup: {
                    from: 'userroles',
                    localField: '_id',
                    foreignField: 'user',
                    as: 'userRole'
                }
            },
            {
                $unwind: {
                    path: '$userRole',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $lookup: {
                    from: 'rolenames',
                    localField: 'userRole.role',
                    foreignField: '_id',
                    as: 'roleName'
                }
            },
            {
                $unwind: {
                    path: '$roleName',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $match: {
                    'roleName.name': 'Customer'
                }
            },
            {
                $lookup: {
                    from: 'petowners',
                    localField: '_id',
                    foreignField: 'user',
                    as: 'owner'
                }
            },
            {
                $unwind: {
                    path: '$owner',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $lookup: {
                    from: 'pets',
                    localField: '_id',
                    foreignField: 'user',
                    as: 'pets'
                }
            },
            {
                $project: {
                    __v: 0,
                    password: 0,
                    userRole: 0,
                    roleName: 0,
                    'profile.user': 0,
                    'profile.__v': 0,
                    'owner.user': 0,
                    'owner.__v': 0,
                    'pets.__v': 0,
                    'pets.user': 0
                }
            }
        ]);

        const result = await getCustomerDataAggregate.exec();

        return res.status(200).json(result);
    } catch (error) {
        return null;
    }
}

export const getStaffs = async (req: TRequest, res: Response) => {
    try {
        const getCustomerDataAggregate: Aggregate<any[]> = User.aggregate([
            {
                $lookup: {
                    from: 'profiles',
                    localField: '_id',
                    foreignField: 'user',
                    as: 'profile'
                }
            },
            {
                $unwind: {
                    path: '$profile',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $lookup: {
                    from: 'userroles',
                    localField: '_id',
                    foreignField: 'user',
                    as: 'userRole'
                }
            },
            {
                $unwind: {
                    path: '$userRole',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $lookup: {
                    from: 'rolenames',
                    localField: 'userRole.role',
                    foreignField: '_id',
                    as: 'roleName'
                }
            },
            {
                $unwind: {
                    path: '$roleName',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $match: {
                    'roleName.name': 'Staff'
                }
            },
            {
                $project: {
                    __v: 0,
                    password: 0,
                    userRole: 0,
                    roleName: 0,
                    'profile.user': 0,
                    'profile.__v': 0,
                }
            }
        ]);

        const result = await getCustomerDataAggregate.exec();

        return res.status(200).json(result);
    } catch (error) {
        return null;
    }
}