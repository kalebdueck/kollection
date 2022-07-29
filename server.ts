import { Application, Router } from "https://deno.land/x/oak/mod.ts";
import * as edgedb from "https://deno.land/x/edgedb/mod.ts";

import index from "./src/controller/index.ts";

const router = new Router();
router.get("/", index);


const app = new Application();
app.use(router.routes());
app.use(router.allowedMethods());

app.addEventListener(
  "listen",
  (e) => console.log("Listening on http://localhost:8080"),
);
await app.listen({ port: 8080 });