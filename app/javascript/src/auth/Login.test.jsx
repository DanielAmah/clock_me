import React from "react";
import { render, cleanup } from "@testing-library/react";
import Login from "./Login";

afterEach(cleanup);

describe("Login", () => {

  function renderLogin() {
    return render(
      <Login />
    )
  }
  test("render correctly", () => {
    const comp = renderLogin();
    expect(comp).toBeDefined();
  });

});
