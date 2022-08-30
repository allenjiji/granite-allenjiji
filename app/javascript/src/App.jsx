import React, { useEffect, useState } from "react";

import { Route, Switch, BrowserRouter as Router } from "react-router-dom";

import { setAuthHeaders } from "apis/axios";
import { initializeLogger } from "common/logger";
import CreateTask from "components/Tasks/Create";

import Dashboard from "./components/Dashboard";
import PageLoader from "./components/PageLoader";

const App = () => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    initializeLogger();
    setAuthHeaders(setLoading);
  }, []);

  if (loading) {
    return (
      <div className="h-screen">
        <PageLoader />
      </div>
    );
  }

  return (
    <Router>
      <Switch>
        <Route exact component={CreateTask} path="/tasks/create" />
        <Route exact component={Dashboard} path="/dashboard" />
      </Switch>
    </Router>
  );
};

export default App;
