import React, { useEffect, useState } from "react";
import moment from "moment";
import { useStyles } from "./styles";
import Paper from "@material-ui/core/Paper";
import Table from "@material-ui/core/Table";
import TableBody from "@material-ui/core/TableBody";
import TableCell from "@material-ui/core/TableCell";
import TableContainer from "@material-ui/core/TableContainer";
import TextField from "@material-ui/core/TextField";
import Button from "@material-ui/core/Button";
import TableHead from "@material-ui/core/TableHead";
import TablePagination from "@material-ui/core/TablePagination";
import TableRow from "@material-ui/core/TableRow";
import AccessTime from "@material-ui/icons/AccessTime";

import { IS_ADMIN } from "../constant";
import {
  getUserEvents,
  createNewEvent,
} from "../services/apiService";
import Navbar from "../components/Navbar";
import TableRowComponent from "../components/TableRowComponent";
import CircularProgress from "@material-ui/core/CircularProgress";

export default function Dashboard({ history }) {
  const classes = useStyles();
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [events, setEvents] = useState([]);
  const [isNewEntry, setIsNewEntry] = useState(false);
  const [description, setDescription] = useState("");
  const [error, setError] = useState("");
  const [dashboardError, setDashboardError] = useState("")
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    setIsLoading(true);
    listAllUserEvents();
  }, []);

  const listAllUserEvents = async () => {
    try {
      const events = await getUserEvents();
      setEvents(events);
      setIsLoading(false);
    } catch (err) {
      throw err.response.data;
    }
  };

  const isAdminString = localStorage.getItem(IS_ADMIN);
  const isAdmin = JSON.parse(isAdminString);

  const columns = [
    { id: "description", label: "Description", minWidth: 170 },
    { id: "profession", label: "Profession", minWidth: 100, align: "center" },
    {
      id: "clock_in_time",
      label: "Clock In Time",
      minWidth: 100,
      align: "center",
    },
    {
      id: "clock_out_time",
      label: "Clock Out Time",
      minWidth: 100,
      align: "center",
    },
    { id: "time_spend", label: "Time Spend", minWidth: 100, align: "center" },
    { id: "clock_out", label: "Clock In / Out", minWidth: 100, align: "right" },

    {
      id: "action",
      label: "Action",
      minWidth: 170,
      align: "right",
      format: (value) => value.toLocaleString("en-US"),
    },
  ];

  const createData = (
    id,
    description,
    profession,
    clock_in_time,
    clock_out_time,
    time_spend,
    clock_out,
    action
  ) => {
    return {
      id,
      description,
      profession,
      raw_clock_in_time: clock_in_time,
      raw_clock_out_time: clock_out_time,
      clock_in_time: moment(clock_in_time).format("MMM Do YYYY, h:mm A"),
      clock_out_time: clock_out_time
        ? moment(clock_out_time).format("MMM Do YYYY, h:mm A")
        : "-",
      time_spend: time_spend ? time_spend : "-",
      action,
      clock_out,
      action,
    };
  };

  const processEventEntries = (events) => {
    return events.map((event) => {
      return createData(
        event.id,
        event.description,
        event.profession,
        event.clock_in,
        event.clock_out,
        event.time_spend,
        "clock_out",
        "admin_actions"
      );
    });
  };

  const handleDescription = (event) => {
    const { value } = event.target;
    setDescription(value);
  };

  const handleNewEvent = async (event) => {
    event.preventDefault();
    const eventData = { description: description.trim() };
    try {
      const response = await createNewEvent(eventData);
      if (response) {
        setIsNewEntry(false);
        setError("");
        listAllUserEvents();
      }
    } catch (err) {
      setError(err.response.data.errors);
      throw err
    }
  };

  const handleNewEntry = () => {
    setIsNewEntry(!isNewEntry);
  };

  const handleChangePage = (newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(+event.target.value);
    setPage(0);
  };

  if (isLoading) {
    return (
      <div
        style={{ display: "flex", justifyContent: "center", height: "90vh" }}
      >
        {" "}
        <CircularProgress />
      </div>
    );
  }

  return (
    <>
      <Navbar history={history} />
      <div style={{ padding: "3%" }}>
        <div
          style={{
            display: "flex",
            justifyContent: "flex-end",
            marginTop: "2%",
            marginBottom: "2%",
          }}
        >
          <Button
            variant="contained"
            style={{ backgroundColor: "#0e8791" }}
            color="primary"
            disableElevation
            onClick={handleNewEntry}
          >
            New Entry
          </Button>
        </div>

        <Paper>
          {isNewEntry && (
            <form
              onSubmit={handleNewEvent}
              style={{ display: "flex", flexDirection: "row" }}
            >
              <TextField
                variant="outlined"
                margin="normal"
                required
                fullWidth
                name="description"
                label="Description"
                id="description"
                autoComplete="description"
                value={description}
                onChange={handleDescription}
                style={{ marginLeft: 20 }}
              />
              <Button
                type="submit"
                variant="contained"
                color="primary"
                disableElevation
                style={{
                  backgroundColor: "#ff6eb0",
                  height: 50,
                  margin: 20,
                }}
                className={classes.auth__submit}
              >
                <AccessTime />
              </Button>
            </form>
          )}
          <div
            style={{ color: "#ff6eb0", marginTop: "1%", textAlign: "center" }}
          >
            {error}
          </div>
        </Paper>
        <div
            style={{ color: "#ff6eb0", marginTop: "1%", textAlign: "center" }}
          >
            {dashboardError}
          </div>
        <Paper className={classes.root}>
          {events && events.length === 0 ? (
            <div>No Events to Display</div>
          ) : (
            <>
              <TableContainer className={classes.container}>
                <Table stickyHeader aria-label="sticky table">
                  <TableHead>
                    <TableRow>
                      {columns.map((column, index) => (
                        <TableCell
                          key={index}
                          align={column.align}
                          style={{ minWidth: column.minWidth }}
                        >
                          {column.label}
                        </TableCell>
                      ))}
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {events &&
                      processEventEntries(events)
                        .slice(
                          page * rowsPerPage,
                          page * rowsPerPage + rowsPerPage
                        )
                        .map((row, index) => {
                          return (
                            <TableRowComponent
                              row={row}
                              columns={columns}
                              key={index}
                              listAllUserEvents={listAllUserEvents}
                              isAdmin={isAdmin}
                              setError={setDashboardError}
                            />
                          );
                        })}
                  </TableBody>
                </Table>
              </TableContainer>
              <TablePagination
                rowsPerPageOptions={[10, 25, 100]}
                component="div"
                count={processEventEntries(events).length}
                rowsPerPage={rowsPerPage}
                page={page}
                onChangePage={handleChangePage}
                onChangeRowsPerPage={handleChangeRowsPerPage}
              />
            </>
          )}
        </Paper>
      </div>
    </>
  );
}
