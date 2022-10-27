const run = () => {
  const app = window.Elm.Main.init({
    flags: null,
  });

  app.ports.interopFromElm.subscribe(({ tag, data }) => {
    switch (tag) {
      case "alert": {
        console.warn(data.message);
      }
    }
  });
};

run();

export {};
