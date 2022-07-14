import 'dotenv/config'
import express, { Express, Request, Response } from 'express'
import cors from 'cors'


export const server: Express = express()
server.use(express.json())
server.use(cors())

server.get('/', (req: Request, res: Response) => res.send('Hello World!')) 