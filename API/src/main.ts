import * as dotenv from 'dotenv';
import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';
import { corsConfig } from './cors.config';

dotenv.config();

async function bootstrap() {
    const PORT = process.env.PORT || 3005;

    const app = await NestFactory.create(AppModule);

    app.enableCors(corsConfig);

    app.useGlobalPipes(
        new ValidationPipe({
            whitelist: true,
            forbidNonWhitelisted: true,
            transform: true,
        }),
    );

    await app.listen(PORT, () =>
        console.log(`API server is running on port ${PORT}`),
    );
}

bootstrap();
