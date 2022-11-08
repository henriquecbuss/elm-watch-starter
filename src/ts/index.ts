import { defineCustomElements } from "../../generated/customElements";
import * as pattern from "ts-pattern";

const run = () => {
  defineCustomElements();
  const counter = localStorage.getItem("counter");

  const app = window.Elm.Main.init({
    flags: {
      counter: counter ? parseInt(counter) : null,
    },
  });

  app.ports.interopFromElm.subscribe((fromElm) => {
    pattern.match(fromElm)
      .with({ tag: "alert" }, ({ data }) => {
        console.warn(data.message);

        app.ports.interopToElm.send({ tag: "alerted" });
      })
      .with({ tag: "scrollTo" }, ({ data }) => {
        document.querySelector(data.querySelector)?.scrollIntoView({
          behavior: "smooth",
        });
      })
      .with({ tag: "storeCounter" }, ({ data }) => {
        localStorage.setItem("counter", data.counter.toString());
      })
      .exhaustive();
  });
};

run();
