import { Module } from '@nestjs/common';
import { HealthController } from './health.controller';
import { OrderEmailController } from './order-email.controller';
@Module({controllers:[HealthController,OrderEmailController]})
export class AppModule {}
