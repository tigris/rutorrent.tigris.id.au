<?php

function sqlite_exists()
{
	if (PHP_VERSION_ID < 50400)
	{
		$result = function_exists("sqlite_open");
	}
	else
	{
		$result = class_exists("SQLite3");
	}
	return $result;
}

function sqlite_open1($filename, $mode = 0666, &$error_msg)
{
	if (PHP_VERSION_ID < 50400)
	{
		$dbhandle = sqlite_open($filename, $mode, $error_msg);
	}
	else
	{
		try
		{
			$dbhandle = new SQLite3($filename);
		}
		catch (Exception $exception)
		{
			$error_msg = $exception->getMessage();
		}
	}
	return $dbhandle;
}

function sqlite_close1($dbhandle)
{
	if (PHP_VERSION_ID < 50400)
	{
		sqlite_close($dbhandle);
	}
	else
	{
		$dbhandle->close();
	}
}

function sqlite_exec1($dbhandle, $query, &$error_msg)
{
	if (PHP_VERSION_ID < 50400)
	{
		sqlite_exec($dbhandle, $query, $error_msg);
	}
	else
	{
		try
		{
			$dbhandle->exec($query);
		}
		catch (Exception $exception)
		{
			$error_msg = $exception->getMessage();
		}
	}
}

function sqlite_query1($dbhandle, $query, &$error_msg)
{
	if (PHP_VERSION_ID < 50400)
	{
		$query = sqlite_unbuffered_query($dbhandle, $query, SQLITE_ASSOC, $error_msg) && $result = strval(sqlite_fetch_single($query));
	}
	else
	{
		try
		{
			$result = strval($dbhandle->querySingle($query));
		}
		catch (Exception $exception)
		{
			$error_msg = $exception->getMessage();
		}
	}
	return $result;
}

function sqlite_escape_string1($item)
{
	if (PHP_VERSION_ID < 50400)
	{
		$result = sqlite_escape_string($item);
	}
	else
	{
		$result = SQLite3::escapeString($item);
	}
	return $result;
}
