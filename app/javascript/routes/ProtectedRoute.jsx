import React from "react";
import { Redirect } from "react-router-dom";
import { AUTH_TOKEN } from "../src/constant";

const ProtectedRoute = ({ component }) => {
  const Component = component;
  const stringifyTokenData = localStorage.getItem(AUTH_TOKEN)
  const token_data = stringifyTokenData ? JSON.parse(stringifyTokenData) : {}

  const { exp } = token_data

  const isAuthenticated = exp > Math.floor(new Date().getTime() / 1000)
  return isAuthenticated ? (
    <Component />
  ) : (
    <Redirect to={{ pathname: "/login" }} />
  );
};


export default ProtectedRoute;
