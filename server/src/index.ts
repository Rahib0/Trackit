import { server } from './server'

const port: string | number = process.env.PORT || 3000

server.listen(port, () =>
	console.log(`\n Express departing now from http://localhost:${port} \n`)
)