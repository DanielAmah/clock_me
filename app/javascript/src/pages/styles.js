import { makeStyles } from '@material-ui/core/styles';

export const useStyles = makeStyles((theme) => ({
  root: {
    marginTop: theme.spacing(10),
    width: "100%",
    minHeight: 400,
    height: "100%",
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  container: {
    maxHeight: 440,
    justifyContent: 'center'
  },
}));