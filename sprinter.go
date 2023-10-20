package raft

import "fmt"

type Sprinter struct {
	fmt string
	args []interface{}
}

func (f Sprinter) String() string {
	return fmt.Sprintf(f.fmt, f.args...)
}

func Fmt(fmt string, args ...interface{}) Sprinter {
	return Sprinter{fmt: fmt, args: args}
}
