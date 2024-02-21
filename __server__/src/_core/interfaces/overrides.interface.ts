import { Request } from 'express-jwt';
import { IProfile } from './schema/schema.interface';

export type TRequest = Request & {
  user: {
    origin: string;
    id: string;
  };
  profile: IProfile;
  from: string;
};
