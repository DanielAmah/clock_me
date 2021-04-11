import React, { Component } from "react";
import ReactDOM from "react-dom";

import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import Signup from "../src/auth/Signup";
import Login from "../src/auth/Login";
import Dashboard from "../src/pages/Dashboard";
import ProtectedRoute from './ProtectedRoute';

// import Book from './src/bookComponent';
// import NavBar from './src/navBar';
// import AllBooks from './src/listBooksComponent';

 const Index = () => {
    return (
      <Router>

          <div>
            {/* <header>
              <NavBar/>
            </header>
            */}

            <Switch>
            <ProtectedRoute path="/" exact={true} component={Dashboard} />
              <Route path="/login" exact={true} component={Login} />
              <Route path="/signup" exact={true} component={Signup} />
            </Switch>
          </div>

      </Router>
    );
}

export default Index;