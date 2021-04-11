import React, { useState } from "react";
import moment from "moment";
import TableCell from "@material-ui/core/TableCell";
import TextField from "@material-ui/core/TextField";
import Button from "@material-ui/core/Button";
import TableRow from "@material-ui/core/TableRow";
import {clockOut, editEvent, trashEvent } from "../services/apiService";
import Delete from "@material-ui/icons/Delete";
import Edit from "@material-ui/icons/Edit";
import Save from "@material-ui/icons/Save";


export default function TableRowComponent({ columns, row, index, listAllUserEvents, isAdmin, setError }) {
  const [state, setState] = useState({
    clockIn: '',
    clockOut: ''
  })
  const [isEditable, setIsEditable] = useState(false);

  const handleClockInAndClockOut = (event) => {
    const value = event.target.value;
    setState({
      ...state,
      [event.target.name]: value,
    });
  }

  const toggleEdit = async (row) => {
    setIsEditable(true)
    setState({
      clockIn: row.raw_clock_in_time,
      clockOut: row.raw_clock_out_time
    })
  }

  const handleEdit = async (row) => {
    if(!state.clockIn || !state.clockOut) {
      setIsEditable(false)
      return
    }
    const eventData = {
      clock_in: moment.utc(state.clockIn).format('YYYY-MM-DDTHH:mm:ss'),
      clock_out: moment.utc(state.clockOut).format('YYYY-MM-DDTHH:mm:ss')
    }

    try {
      await editEvent(row.id, eventData)
      setIsEditable(false)
      setError("")
      listAllUserEvents();
    }
    catch(err) {
      setError(err.response.data.errors)
      console.error(err)
    }
  }

  const handleTrash = async (row) => {
    try {
      await trashEvent(row.id)
      listAllUserEvents();
    }
    catch(err) {
      console.error(err)
    }
  }

  const clockOutBtn = (row) => {
    
    return (
      <Button disabled={row.clock_out_time !== '-'} variant="contained" color="primary" style={{backgroundColor: `${row.clock_out_time !== '-' ? '' : '#0e8791'}`}} disableElevation onClick={() => handleClockOut(row)}>
        Clock Out
      </Button>
    );
  };

  const handleClockOut = async (row) => {
    try {
      await clockOut(row.id)
      listAllUserEvents();
    }
    catch(err) {
      console.error(err)
    }
  }


  const handleAdminActions = (row) => {
    return (
      <>
      {isEditable ? (<Button variant="contained" color="primary"  style={{backgroundColor: '#0e8791'}} disableElevation onClick={() => handleEdit(row)} >
          <Save />
        </Button>) : (
        <Button variant="contained" color="primary"  style={{backgroundColor: `${row.clock_out_time === '-' ? '' : '#0e8791'}`}}  disabled={row.clock_out_time === '-'} disableElevation onClick={() => toggleEdit(row)} >
          <Edit />
        </Button>
        )}
        {' '}
        {isAdmin && <Button variant="contained" color="secondary"  style={{backgroundColor: '#ff6eb0'}} disableElevation onClick={() => handleTrash(row)}>
          <Delete />
        </Button>}
       
      </>
    );
  };

  const handleEventEntryRow = (value, column_id) => {
    if(column_id === 'clock_in_time' && isEditable) {
      return  <TextField
          variant="outlined"
          margin="normal"
          required
          fullWidth
          name="clockIn"
          type="datetime-local"
          id={column_id}
          autoComplete="clockin"
          value={moment(state.clockIn).format('YYYY-MM-DDTHH:mm:ss')}
          onChange={handleClockInAndClockOut}
      />
    }
    if (column_id === 'clock_out_time' && isEditable){
      return  <TextField
      variant="outlined"
      margin="normal"
      required
      fullWidth
      name="clockOut"
      type="datetime-local"
      id={column_id}
      autoComplete="clockout"
      value={moment(state.clockOut).format('YYYY-MM-DDTHH:mm:ss')}
      onChange={handleClockInAndClockOut}
    />
    }
    return value
  }

  return (
    <>
        <TableRow
          hover
          role="checkbox"
          tabIndex={-1}
          key={index}
        >
          {columns.map((column, index) => {
            const value = row[column.id];
            return (
              <TableCell key={index} align={column.align}>
                {column.format && typeof value === "number"
                  ? column.format(value)
                  : value === "clock_out"
                  ? clockOutBtn(row)
                  : value === "admin_actions"
                  ? handleAdminActions(row)
                  : handleEventEntryRow(value, column.id)}
              </TableCell>
            );
          })}
        </TableRow>
        </>
         
  )
}