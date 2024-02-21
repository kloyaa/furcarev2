import { Request } from 'express-jwt';
import { IProfile } from './schema/schema.interface';
import { type Response } from 'express';

export type TRequest = Request & {
  user: {
    origin: string;
    id: string;
  };
  profile: IProfile;
  from: string;
};

export type TResponse = Response;
