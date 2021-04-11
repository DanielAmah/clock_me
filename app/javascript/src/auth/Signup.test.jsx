import React from "react";
import { render, cleanup } from "@testing-library/react";
import Signup from "./Signup";

afterEach(cleanup);

describe("Signup", () => {

  function renderSignup() {
    return render(
      <Signup />
    )
  }
  test("render correctly", () => {
    const comp = renderSignup();
    expect(comp).toBeDefined();
  });

});
