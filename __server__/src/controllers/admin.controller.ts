import { Aggregate } from "mongoose";
import { TRequest } from "../_core/interfaces/overrides.interface";
import { type Response } from 'express';
import User from "../models/user.model";
import Activity from "../models/activity.model";

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

export const getCheckInStats = async (req: TRequest, res: Response) => {
    try {
        const currentYear = new Date().getFullYear();

        const checkInStats = await Activity.aggregate([
            {
                $match: {
                    description: 'Login success',
                    createdAt: {
                        $gte: new Date(`${currentYear}-01-01`), // Start of the current year
                        $lte: new Date(`${currentYear}-12-31`)  // End of the current year
                    }
                }
            },
            {
                $group: {
                    _id: { $month: '$createdAt' },
                    count: { $sum: 1 }
                }
            },
            {
                $project: {
                    _id: 0,
                    month: '$_id',
                    count: 1
                }
            }
        ]);

        // Manually generate the months array
        const months = [
            'January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December'
        ];

        // Create an object to store the result
        const result: { [key: string]: number } = {};

        // Initialize counts for all months to 0
        for (const month of months) {
            result[month] = 0;
        }

        // Update counts for months where data is available
        for (const stat of checkInStats) {
            result[months[stat.month - 1]] = stat.count;
        }


        return res.status(200).json(Object.entries(result).map(([month, count]) => ({ [month.toLowerCase()]: count })));
    } catch (error) {
        console.error('@getCheckInStats error', error);
        return res.status(500).json({ error: 'Internal Server Error' });
    }
};
