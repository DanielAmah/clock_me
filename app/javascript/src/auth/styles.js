import { makeStyles } from '@material-ui/core/styles';

export const useStyles = makeStyles((theme) => ({
  auth__paper: {
    marginTop: theme.spacing(20),
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  auth__avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.secondary.main,
  },
  auth__form: {
    width: '100%',
    marginTop: theme.spacing(1),
  },
  auth__submit: {
    margin: theme.spacing(3, 0, 2),
  },

}));
