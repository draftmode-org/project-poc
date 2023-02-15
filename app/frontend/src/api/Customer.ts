export const customerApi = {
  put: function (id: string, data: customerInterface) {
    return {
      id: id,
      name: data.name,
      address: data.address,
      city: data.city
    }
  },
  fetch: function (id : string) : customerInterface {
    return {
      id: id,
      address: `Street ${id}`,
      city: "Vienna",
      name: `Max #${id} Mustermann`
    }
  },
  fetchAll: function () {
    return [
      this.fetch("1"),
      this.fetch("2"),
    ]
  }
}