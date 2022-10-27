const run = () => {
  const counter = localStorage.getItem("counter");

  const app = window.Elm.Main.init({
    flags: {
      counter: counter ? parseInt(counter) : null,
    },
  });

  app.ports.interopFromElm.subscribe(({ tag, data }) => {
    switch (tag) {
      case "alert": {
        console.warn(data.message);

        app.ports.interopToElm.send({ tag: "alerted" });

        break;
      }

      case "storeCounter": {
        localStorage.setItem("counter", data.counter.toString());

        break;
      }
    }
  });
};

run();

export {};
