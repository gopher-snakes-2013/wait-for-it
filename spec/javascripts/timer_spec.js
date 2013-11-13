describe("timer update", function(){
  it("returns a correctly formatted date and time", function(){
    expect(updateReservations.calculateCurrentTime()).toMatch(/[A-Z][a-z]{2}\s\d{1,2},\s\d{4}/)
    })

  })