const cds = require("@sap/cds")

module.exports = class ODataService extends cds.ApplicationService {

  async init() {
    // http://localhost:4004/odata/Peoples(cbae1928-28dd-4af2-97fb-34de26b2f843)/getName()
    this.on("getName", async function (req) {
      const item = await this.run(req.query)
      return item?.[0]?.UserName ?? ""
    })
    // POST localhost:4004/odata/Peoples(cbae1928-28dd-4af2-97fb-34de26b2f843)/updateName
    this.on("updateName", async function (req) {
      const items = await this.run(req.query)
      if (items.length > 0) {
        await Promise.all(items.map(item => this.run(UPDATE.entity("People", item.ID).with({ UserName: req.data.UserName }))))
      }
    })
    // http://localhost:4004/odata/getPeopleName(ID=cbae1928-28dd-4af2-97fb-34de26b2f843)
    this.on("getPeopleName", async function (req) {
      return (await this.run(SELECT.one.from("People", req.data.ID)))?.UserName ?? ""
    })
    this.on("updatePeopleName", async function (req) {
      return this.run(UPDATE.entity("People", req.data.ID).with({ UserName: req.data.UserName }))
    })
    await super.init()
  }
}