import React from "react";
import { render, cleanup } from "@testing-library/react";
import Dashboard from "./Dashboard";
import { BrowserRouter as Router } from 'react-router-dom';

afterEach(cleanup);

describe("Dashboard", () => {

  function renderDashboard() {
    return render(
      <Router><Dashboard /></Router>
    )
  }
  test("render correctly", () => {
    const comp = renderDashboard();
    expect(comp).toBeDefined();
  });

});
