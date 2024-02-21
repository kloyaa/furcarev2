import Profile from "../models/profile.model";
import { IProfile } from "../_core/interfaces/schema/schema.interface";

export const findProfileByUser = async (user: string): Promise<IProfile | null> => {
    try {
        const profile = await Profile.findOne({ user });
        if(!profile) {
            return null;
        }

        return profile;
    } catch (error) {
        return null;
    }
};