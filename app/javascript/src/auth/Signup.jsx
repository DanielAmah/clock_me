import React, { useState, useEffect } from "react";
import Avatar from "@material-ui/core/Avatar";
import Button from "@material-ui/core/Button";
import CssBaseline from "@material-ui/core/CssBaseline";
import TextField from "@material-ui/core/TextField";
import Link from "@material-ui/core/Link";
import Grid from "@material-ui/core/Grid";
import Select from "@material-ui/core/Select";
import MenuItem from "@material-ui/core/MenuItem";
import InputLabel from "@material-ui/core/InputLabel";
import LockOutlinedIcon from "@material-ui/icons/LockOutlined";
import Typography from "@material-ui/core/Typography";
import Container from "@material-ui/core/Container";
import FormControl from "@material-ui/core/FormControl";
import { useStyles } from "./styles";
import apiClient from "../utils/apiClient";
import { getProfessions, createUser } from "../services/apiService";

export default function Signup({ history }) {
  const [state, setState] = useState({
    username: "",
    email: "",
    password: "",
    profession: "",
  });
  const [allProfessions, setAllProfessions] = useState([]);

  const [errors, setErrors] = useState("");

  const classes = useStyles();

  useEffect(() => {
    getAllProfessions();
  }, []);

  const getAllProfessions = async () => {
    const response = await getProfessions();
    setAllProfessions(response);
  };

  const handleChange = (event) => {
    const value = event.target.value;
    setState({
      ...state,
      [event.target.name]: value,
    });
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    const user = {
      email: state.email.trim(),
      username: state.username.trim(),
      password: state.password.trim(),
      profession: state.profession.trim(),
      password_confirmation: state.password.trim(),
    };

    try {
      const response = await createUser(user);
      if (response) {
        history.push("/login");
        setErrors("")
      }
    } catch (error) {
      setErrors(error.response.data.errors);
      throw error.response.data
    }
  };

  return (
    <Container component="main" maxWidth="xs">
      <CssBaseline />
      <div className={classes.auth__paper}>
        <Avatar className={classes.auth__avatar}>
          <img src="https://static.intercomassets.com/avatars/4516833/square_128/custom_avatar-1611326961.png?1611326961" alt="" width="32" height="32" />
        </Avatar>
        <Typography component="h1" variant="h5">
          Sign up
        </Typography>
        <div style={{color: "#ff6eb0", marginTop: '3%'}}>{errors}</div>
        <form onSubmit={handleSubmit} className={classes.auth__form}>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="email"
            label="Email"
            name="email"
            autoComplete="email"
            autoFocus
            value={state.email}
            onChange={handleChange}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="user name"
            label="User Name"
            name="username"
            autoComplete="username"
            autoFocus
            value={state.username}
            onChange={handleChange}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            name="password"
            label="Password"
            type="password"
            id="password"
            autoComplete="current-password"
            value={state.password}
            onChange={handleChange}
          />
          <FormControl className={classes.formControl} fullWidth>
            <InputLabel id="label">Select a Profession</InputLabel>
            <Select
              fullWidth
              labelId="profession"
              id="profession"
              value={state.profession}
              name="profession"
              onChange={handleChange}
            >
              <MenuItem value="">
                <em>Select a Profession</em>
              </MenuItem>
              {allProfessions && allProfessions.map((profession) => (
                <MenuItem key={profession.id} value={profession.name}>{profession.name}</MenuItem>
              ))}
            </Select>
          </FormControl>
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            className={classes.auth__submit}
            style={{backgroundColor: '#0e8791'}}
          >
            Sign Up
          </Button>
          <Grid container>
            <Grid item>
              <Link href="/login" variant="body2"  style={{color: '#0e8791'}}>
                {"Already a member? Login"}
              </Link>
            </Grid>
          </Grid>
        </form>
      </div>
    </Container>
  );
}
