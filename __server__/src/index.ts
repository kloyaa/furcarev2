import express, { type Application } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { connectDB } from './_core/utils/db/db.util';
import { getEnv } from './_core/config/env.config';
import { maintenanceModeMiddleware } from './_core/middlewares/maintenance-mode.middleware';

import authRoute from './routes/auth.route';
import userRoute from './routes/user.route';
import ownerRoute from './routes/pet_owner.route';
import petRoute from './routes/pet.route';
import adminRoute from './routes/admin.route';
import serviceRoute from './routes/service_fee.route';
import cageRoute from './routes/cage.route';
import groomingApplicationRoute from './routes/grooming_application.route';
import scheduleRoute from './routes/schedule.route';
import boardingApplicationRoute from './routes/boarding_application.service';
import bookingRoute from './routes/booking.route';
import transitApplicationRoute from './routes/transit_application.route';

import { requestLoggerMiddleware } from './_core/middlewares/request-logger.middleware';
import { allowApiAccessMiddleware } from './_core/middlewares/allow-access.middleware';

const app: Application = express();

async function runApp() {
  const env = await getEnv();
  app.use(helmet());
  app.use(
    cors({
      exposedHeaders: ['X-Nodex-DateTime'],
    }),
  );
  app.use(express.json());

  app.use(allowApiAccessMiddleware);
  app.use(maintenanceModeMiddleware);
  app.use(requestLoggerMiddleware);

  app.use('/api', authRoute);
  app.use('/api', userRoute);
  app.use('/api', ownerRoute);
  app.use('/api', petRoute);
  app.use('/api', adminRoute);
  app.use('/api', serviceRoute);
  app.use('/api', cageRoute);
  app.use('/api', scheduleRoute);
  app.use('/api', groomingApplicationRoute);
  app.use('/api', boardingApplicationRoute);
  app.use('/api', transitApplicationRoute);
  app.use('/api', bookingRoute);

  connectDB();

  app.listen(Number(env?.PORT) || 5000, () => {
    console.log('@environment ', env?.ENVIRONMENT);
    console.log('@port ', Number(env?.PORT));
  });
}

runApp();
