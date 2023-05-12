export const corsConfig = {
    origin: [process.env.FRONTEND_ORIGIN || ''],
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
};
