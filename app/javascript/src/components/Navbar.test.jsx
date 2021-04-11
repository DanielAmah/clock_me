import React from "react";
import { render, cleanup } from "@testing-library/react";
import Navbar from "./Navbar";
import { BrowserRouter as Router } from 'react-router-dom';

afterEach(cleanup);

describe("Navbar", () => {

  function renderNavbar() {
    return render(
      <Router><Navbar /></Router>
      
    )
  }
  test("render correctly", () => {
    const comp = renderNavbar();
    expect(comp).toBeDefined();
  });

});
