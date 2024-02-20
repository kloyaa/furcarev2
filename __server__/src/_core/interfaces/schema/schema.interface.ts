import { Types } from 'mongoose';
import { BookingStatus } from '../../enum/booking.enum';

export interface IUser extends Document {
  username: string;
  email: string;
  password: string;
}

export interface IProfile extends Document {
  user: Types.ObjectId;
  firstName: string;
  lastName: string;
  birthdate: Date;
  address: {
    present: string;
    permanent: string;
  };
  contact: {
    email: string;
    number: string;
  };
  gender: string;
}

export interface IRequestLog extends Document {
  timestamp: Date;
  clientIp: string;
  requestMethod: string;
  requestUrl: string;
  userAgent: string;
  requestBody?: any;
  responseStatus: number;
  responseStatusMessage: string;
  elapsed: number;
}

export interface IRoleName extends Document {
  name: string;
}

export interface IUserRole extends Document {
  user: Types.ObjectId;
  role: Types.ObjectId;
}

export interface IPetOwner extends Document {
  user: Types.ObjectId;
  name: string;
  address: string;
  mobileNo: string;
  email: string;
  emergencyContactNo: string;
  work: string;
}

export interface IPet extends Document {
  user: Types.ObjectId;
  name: string;
  specie: string;
  age: number;
  gender: string;
  identification: string;
  additionalInfo: {
    historyOfBitting: boolean;
    feedingInstructions: string;
    medicationInstructions: string;
  }
}

export interface IBooking extends Document {
  user: Types.ObjectId;
  staff?: Types.ObjectId;
  pet: Types.ObjectId;
  application: Types.ObjectId;
  status: BookingStatus;
  payable: Number;
}

export interface IGroomingApplication extends Document {
  serviceName: string;
  otherInformation: string;
  schedule: Types.ObjectId;
}

export interface IBoardingApplication extends Document {
  serviceName: string;
  schedule: Date;
  daysOfStay: Number;
  cage: Types.ObjectId;
}

export interface ITransitApplication extends Document {
  schedule: Date;
}

export interface IBookingSchedule extends Document {
  title: string;
}

export interface IBookingCage extends Document {
  title: string;
}

